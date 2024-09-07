// import express from 'express';
import bcrypt from "bcrypt";
import { PrismaClient } from '@prisma/client';

import { differenceInMinutes, parse } from 'date-fns';

const prisma = new PrismaClient();

// export const createUser = async(req,res)=>{

//     const { uuid, email, name, password, currentLocation } = req.body;
//     try {
//       const user = await prisma.user.create({
//         data: {
//           uuid,
//           email,
//           name,
//           password, // Note: In a real app, you should hash the password
//           currentLocation
//         },
//       });
//       res.json(user);
//     } catch (error) {
//       res.status(400).json({ error: error.message });
//     }
// };


export const register = async (req, res) => {
  try {
    const { uuid, email, name, password, currentLocation } = req.body;

    const salt = await bcrypt.genSalt();
    const passwordHash = await bcrypt.hash(password, salt);

    try {
      const user = await prisma.user.create({
        data: {
          uuid,
          email,
          name,
          password: passwordHash, // Storing the hashed password
          currentLocation,
        },
      });
      res.json(user);
    } catch (error) {
      res.status(400).json({ error: error.message });
    }
  } catch (err) {
    res.status(500).json({ error: err.message }); // This is the missing catch block
  }
};


//LOGGING IN

export const loginUser = async (req,res) =>{
  try{
      const {email,password} = req.body;
      const user = await prisma.user.findUnique({ where: { email: email } });
      if(!user) return res.status(400).json({msg: "invalid credentials. "});


      const isMatch = await bcrypt.compare(password, user.password);
      if (!isMatch) return res.status(400).json({ msg: "Invalid credentials. " });
  

      // const token = jwt.sign({ id : user._id} , process.env.JWT_SECRET);
      // so that passsword doesnt get send back to frontend
      delete user.password;
      res.status(200).json({user: {
        id: user.id,
        uuid: user.uuid,
        email: user.email,
        name: user.name,
        currentLocation: user.currentLocation,
      }});
      
  }
  catch(err){
      res.status(500).json({ error : err.message});
  }
}


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
  const { currentTime, entered } = req.body;

  try {
    const user = await prisma.user.findUnique({
      where: { uuid },
    });

    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }

    const dateKey = new Date(currentTime).toISOString().split('T')[0];
    const timeValue = new Date(currentTime).toISOString().split('T')[1].split('.')[0];

    const field = entered === "true" ? "entryTimes" : "exitTimes";

    let updatedTimes = {};
    if (typeof user[field] === 'object' && user[field] !== null) {
      updatedTimes = user[field];
    } else {
      try {
        updatedTimes = JSON.parse(user[field] || "{}");
      } catch (error) {
        console.error(`Error parsing ${field}, initializing as empty object:`, error);
      }
    }

    if (!updatedTimes[dateKey]) {
      updatedTimes[dateKey] = [];
    }
    updatedTimes[dateKey].push(timeValue);

    const updateData = {
      [field]: updatedTimes,
    };

    if (entered === "true") {
      updateData.inCount = {
        increment: 1
      };
    } else {
      updateData.outCount = {
        increment: 1
      };
    }

    const updatedUser = await prisma.user.update({
      where: { uuid },
      data: updateData,
    });

    res.json({ 
      status: 'OK', 
      updatedTimes: updatedUser[field]
    });
  } catch (error) {
    console.error("Error updating timestamp:", error);
    res.status(400).json({ error: error.message });
  }
};






export const getTotalTime = async (req, res) => {
  const { uuid, date } = req.params;

  try {
    // get the user data including entryTimes and exitTimes
    const user = await prisma.user.findUnique({
      where: { uuid },
    });

    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }

    // parse entryTimes and exitTimes
    const entryTimes = user.entryTimes && typeof user.entryTimes === 'object' ? user.entryTimes : JSON.parse(user.entryTimes || '{}');
    const exitTimes = user.exitTimes && typeof user.exitTimes === 'object' ? user.exitTimes : JSON.parse(user.exitTimes || '{}');

    // get the times for specific date
    const entryTimesForDate = entryTimes[date] || [];
    const exitTimesForDate = exitTimes[date] || [];

    if (entryTimesForDate.length === 0 || exitTimesForDate.length === 0) {
      return res.status(400).json({ error: 'No entry or exit times found for this date' });
    }

    let totalTime = 0;

    // calculate total time spent in office
    for (let i = 0; i < Math.min(entryTimesForDate.length, exitTimesForDate.length); i++) {
      const entryTime = new Date(`${date}T${entryTimesForDate[i]}`);
      const exitTime = new Date(`${date}T${exitTimesForDate[i]}`);

      const timeSpent = differenceInMinutes(exitTime, entryTime);
      totalTime += timeSpent;
    }

    // convert totalTime to hours
    const hoursSpent = totalTime / 60;

    // prepare the updated totalTimeIn object
    let totalTimeIn = user.totalTimeIn && typeof user.totalTimeIn === 'object' ? user.totalTimeIn : JSON.parse(user.totalTimeIn || '{}');
    totalTimeIn[date] = hoursSpent;

    // update the totalTimeIn field with the calculated time for the given date
    await prisma.user.update({
      where: { uuid },
      data: {
        totalTimeIn,
      },
    });

    res.json({ date, totalTime: hoursSpent });
  } catch (error) {
    console.error("Error calculating total time:", error);
    res.status(500).json({ error: error.message });
  }
};