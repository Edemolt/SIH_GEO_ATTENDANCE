import express, { json } from 'express';
import userRouter from '../routes/userRoutes.js'; // Import the userRouter
import cors from 'cors';

const app = express();
app.use(cors());

app.use(json());

app.use('/users', userRouter); // Use the userRouter for all /users routes



const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});