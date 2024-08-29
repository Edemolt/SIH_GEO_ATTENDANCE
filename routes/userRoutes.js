import { Router } from 'express';
import { PrismaClient } from '@prisma/client';
import { createUser, getAllUsers, getUserByUuid, updateUser, deleteUser, updateTimestamp } from '../controller/users.js';

const prisma = new PrismaClient();
const userRouter = Router();

// Create a new user
userRouter.post('/', /*authMiddleware in all the routes */ createUser);

// Get all users
userRouter.get('/', getAllUsers);

// Get user by UUID
userRouter.get('/:uuid', getUserByUuid);

// Update user
userRouter.put('/:uuid', updateUser);

// Delete user
userRouter.delete('/:uuid', deleteUser);


userRouter.post('/:uuid/timestamp', updateTimestamp);


export default userRouter;