import dotenv from 'dotenv';

dotenv.config();
import App from './app.js';
import { pool } from './config/db.js';
pool.connect()
  .then(() => {
    console.log('Connected to the database');
  })
  .catch((err) => {
    console.error('Error connecting to the database', err);
  });

const PORT = process.env.PORT || 3000;
App.get('/health',(req,res)=>{
  res.status(200).json({message:'Server is healthy'})
})
App.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});