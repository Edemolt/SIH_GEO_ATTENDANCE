// import express from 'express';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

export const createUser = async(req,res)=>{

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
};

export const getAllUsers = async(req,res)=>{
    const users = await prisma.user.findMany();
    res.json(users);
};

export const getUserByUuid = async(req,res)=>{
    const { uuid } = req.params;
  const user = await prisma.user.findUnique({ where: { uuid } });
  if (user) {
    res.json(user);
  } else {
    res.status(404).json({ error: 'User not found' });
  }
};

export const updateUser = async(req, res) => {

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
};

export const deleteUser = async(req, res) => {
    const { uuid } = req.params;
  try {
    await prisma.user.delete({ where: { uuid } });
    res.json({ message: 'User deleted successfully' });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};


export const updateTimestamp = async (req, res) => {
    const { uuid } = req.params;
    const { currentTime, entered } = req.body; // Extract currentTime and entered from request body
  
    try {
      let updatedUser;
  
      if (entered) {
        // If the employee entered the premise, push the current time to entryTimes array
        updatedUser = await prisma.user.update({
          where: { uuid },
          data: {
            entryTimes: {
              push: new Date(currentTime),
            },
          },
        });
      } else {
        // If the employee exited the premise, push the current time to exitTimes array
        updatedUser = await prisma.user.update({
          where: { uuid },
          data: {
            exitTimes: {
              push: new Date(currentTime),
            },
          },
        });
      }
  
      res.json({ status: 'OK', user: updatedUser });
    } catch (error) {
      res.status(400).json({ error: error.message });
    }
  };