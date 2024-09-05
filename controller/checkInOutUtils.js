import { PrismaClient } from '@prisma/client';
const prisma = new PrismaClient();

export default prisma;

async function checkInUser(employeeId, locationName, now = new Date()) {
  const user = await prisma.user.findUnique({
    where: { id: employeeId },
  });

  if (!user) {
    throw new Error('User not found.');
  }

  // Performing the check-in update
  const updatedUser = await prisma.user.update({
    where: { id: employeeId },
    data: {
      currentLocation: locationName,
      inCount: { increment: 1 },
      entryTimes: {
        set: [...(user.entryTimes || []), now.toISOString()],
      },
    },
  });

  return updatedUser;
}

async function checkOutUser(employeeId, locationName, now = new Date()) {
  const user = await prisma.user.findUnique({
    where: { id: employeeId },
  });

  if (!user) {
    throw new Error('User not found.');
  }

  // Performing the check-out update
  const updatedUser = await prisma.user.update({
    where: { id: employeeId },
    data: {
      currentLocation: locationName,
      outCount: { increment: 1 },
      exitTimes: {
        set: [...(user.exitTimes || []), now.toISOString()],
      },
    },
  });

  return updatedUser;
}

module.exports = { checkInUser, checkOutUser };
