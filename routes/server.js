const express = require('express');
const userRouter = require('./routes/userRoutes');
const locationRouter = require('./routes/locationRoutes');
const remoteCheckRouter = require('./routes/remoteCheckRoutes');

const app = express();
app.use(express.json());

// Use routers
app.use('/users', userRouter);
app.use('/location', locationRouter);
app.use('/remote', remoteCheckRouter);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});