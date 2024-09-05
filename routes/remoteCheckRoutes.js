import express from 'express';
import { checkInUser, checkOutUser } from 'controller/checkInOutUtils';
import axios from 'axios';

const router = express.Router();

// Function to get location name from latitude and longitude
async function getLocationName(latitude, longitude) {
  try {
    const response = await axios.get(
      `https://nominatim.openstreetmap.org/reverse?format=json&lat=${latitude}&lon=${longitude}&zoom=18&addressdetails=1`
    );
    return response.data.display_name;
  } catch (error) {
    console.error('Error fetching location name:', error);
    throw new Error('Failed to get location name');
  }
}

// Route for remote check-in
router.post('/remote-check-in', async (req, res) => {
  const { employeeId, latitude, longitude } = req.body;

  if (!employeeId || !latitude || !longitude) {
    return res.status(400).json({ error: 'Missing required parameters' });
  }

  try {
    const locationName = await getLocationName(latitude, longitude);
    const checkInTime = new Date();
    await checkInUser(employeeId, locationName, checkInTime);

    res.status(201).json({ message: 'Checked in remotely', checkInTime, location: locationName });
  } catch (error) {
    console.error('Error during remote check-in:', error);
    res.status(500).json({ error: 'An error occurred during remote check-in.' });
  }
});

// Route for remote check-out
router.post('/remote-check-out', async (req, res) => {
  const { employeeId, latitude, longitude } = req.body;

  if (!employeeId || !latitude || !longitude) {
    return res.status(400).json({ error: 'Missing required parameters' });
  }

  try {
    const locationName = await getLocationName(latitude, longitude);
    const checkOutTime = new Date();
    await checkOutUser(employeeId, locationName, checkOutTime);

    res.status(201).json({ message: 'Checked out remotely', checkOutTime, location: locationName });
  } catch (error) {
    console.error('Error during remote check-out:', error);
    res.status(500).json({ error: 'An error occurred during remote check-out.' });
  }
});

export default router;