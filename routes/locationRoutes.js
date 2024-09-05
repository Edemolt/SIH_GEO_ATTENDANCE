import { PrismaClient } from '@prisma/client';
import express from 'express';

const prisma = new PrismaClient();
const app = express();
app.use(express.json()); 

// Constants for the office location (latitude, longitude)
const OFFICE_LATITUDE = 37.7749; // Example office latitude
const OFFICE_LONGITUDE = -122.4194; // Example office longitude
const CHECK_IN_RADIUS_METERS = 200; // 200 meters radius

// function to convert latitude and longitude to Cartesian coordinates
function latLonToCartesian(lat, lon) {
  const R = 6371e3; // Earth radius in meters
  const x = R * Math.cos(lat) * Math.cos(lon);
  const y = R * Math.cos(lat) * Math.sin(lon);
  const z = R * Math.sin(lat);
  return { x, y, z };
}

//  function to calculate the Euclidean distance between two Cartesian points
function calculateEuclideanDistance(lat1, lon1, lat2, lon2) {
  const p1 = latLonToCartesian(lat1, lon1);
  const p2 = latLonToCartesian(lat2, lon2);
  return Math.sqrt(
    Math.pow(p2.x - p1.x, 2) +
    Math.pow(p2.y - p1.y, 2) +
    Math.pow(p2.z - p1.z, 2)
  );
}

// Route to handle automatic check-in/check-out based on location
app.post('/location-update', async (req, res) => {
  try {
    const { employeeId, latitude, longitude } = req.body;

    // Converting office latitude and longitude to radians
    const officeLatRad = OFFICE_LATITUDE * (Math.PI / 180);
    const officeLonRad = OFFICE_LONGITUDE * (Math.PI / 180);
    const userLatRad = latitude * (Math.PI / 180);
    const userLonRad = longitude * (Math.PI / 180);

    // Calculating the distance from the office
    const distance = calculateEuclideanDistance(
      userLatRad,
      userLonRad,
      officeLatRad,
      officeLonRad
    );

    // Fetching the user record
    const user = await prisma.user.findUnique({
      where: { id: employeeId },
    });

    if (!user) {
      return res.status(404).json({ error: 'User not found.' });
    }

    const now = new Date();

    // Checking if the user is already checked in without checking out
    const isCurrentlyCheckedIn = user.currentLocation === 'Office';

    if (distance <= CHECK_IN_RADIUS_METERS) {
      // User is within 200 meters of the office
      if (!isCurrentlyCheckedIn) {
        // Check-in the user if they are not already checked in
        await prisma.user.update({
          where: { id: employeeId },
          data: {
            currentLocation: 'Office',
            inCount: { increment: 1 },
            entryTimes: {
              set: [...(user.entryTimes || []), now.toISOString()],
            },
          },
        });
        return res.json({ message: 'Checked in', time: now });
      } else {
        // If already checked in, return a message indicating they are already checked in
        return res.json({ message: 'User already checked in', time: now });
      }
    } else {
      // User is outside the 200 meters radius of the office
      if (isCurrentlyCheckedIn) {
        // Check-out the user if they are currently checked in
        await prisma.user.update({
          where: { id: employeeId },
          data: {
            currentLocation: 'Outside Office',
            outCount: { increment: 1 },
            exitTimes: {
              set: [...(user.exitTimes || []), now.toISOString()],
            },
          },
        });
        return res.json({ message: 'Checked out', time: now });
      }
    }

    res.json({ message: 'No change in status', distance });
  } catch (error) {
    console.error('Error during location update:', error);
    res.status(500).json({ error: 'An error occurred during location update.' });
  }
});

app.listen(3000, () => {
  console.log('Server started on port 3000');
});
