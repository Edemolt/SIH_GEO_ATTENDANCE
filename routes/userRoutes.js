import { Router } from 'express';
import { PrismaClient } from '@prisma/client';
import { register, getAllUsers, getUserByUuid, updateUser, deleteUser, updateTimestamp, getTotalTime, loginUser} from '../controller/users.js';

const prisma = new PrismaClient();
const userRouter = Router();

// Create a new user
userRouter.post('/signup', /*authMiddleware in all the routes */ register);

userRouter.post('/login', loginUser);

// Get all users
userRouter.get('/', getAllUsers);

// Get user by UUID
userRouter.get('/:uuid', getUserByUuid);

// Update user
userRouter.put('/:uuid', updateUser);

// Delete user
userRouter.delete('/:uuid', deleteUser);

// update entry and exit
userRouter.post('/:uuid/timestamp', updateTimestamp);

//get total time spent in office
userRouter.get('/:uuid/totalTime/:date', getTotalTime);


export default userRouter;