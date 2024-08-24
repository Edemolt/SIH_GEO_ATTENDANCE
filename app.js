const express = require('express');
const { PrismaClient } = require('@prisma/client');

const prisma = new PrismaClient();
const app = express();

app.use(express.json());

// Create a new user
app.post('/users', async (req, res) => {
  const { uuid, email, name, password, currentLocation } = req.body;
  try {
    const user = await prisma.user.create({
      data: {
        uuid,
        email,
        name,
        password, // Note: In a real app, you should hash the password
        currentLocation
      },
    });
    res.json(user);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Get all users
app.get('/users', async (req, res) => {
  const users = await prisma.user.findMany();
  res.json(users);
});

// Get user by UUID
app.get('/users/:uuid', async (req, res) => {
  const { uuid } = req.params;
  const user = await prisma.user.findUnique({ where: { uuid } });
  if (user) {
    res.json(user);
  } else {
    res.status(404).json({ error: 'User not found' });
  }
});

// Update user
app.put('/users/:uuid', async (req, res) => {
  const { uuid } = req.params;
  try {
    const user = await prisma.user.update({
      where: { uuid },
      data: req.body,
    });
    res.json(user);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Delete user
app.delete('/users/:uuid', async (req, res) => {
  const { uuid } = req.params;
  try {
    await prisma.user.delete({ where: { uuid } });
    res.json({ message: 'User deleted successfully' });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});