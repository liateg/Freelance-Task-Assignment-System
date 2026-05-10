import { pool } from "../../config/db.js";
import { type Request, type Response } from "express";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";

const JWT_SECRET = process.env.JWT_SECRET || "loa-test";
const REFRESH_SECRET = process.env.REFRESH_SECRET || "loa-refresh-test";

const generateAccessToken=(user:{id:number,full_name:string,email:string,role:string})=>{
    const payload={id:user.id,fullName:user.full_name,email:user.email,role:user.role}
    return jwt.sign(payload,JWT_SECRET,{expiresIn:"72h"})
}

const generateRefreshToken = (user: { id: number }) => {
  return jwt.sign(
    { id: user.id },
    REFRESH_SECRET,
    { expiresIn: "7d" }
  );
};

export const registerUser = async (req: Request, res: Response) => {
  const { fullName, email, password } = req.body;

  try {
    // 1. Validate input
    if (!fullName || !email || !password) {
      return res.status(400).json({ message: "All fields are required" });
    }

    // 2. Check if user exists
    const existingUser = await pool.query(
      "SELECT id FROM users WHERE email = $1",
      [email]
    );

    if (existingUser.rows.length > 0) {
      return res.status(400).json({ message: "User already exists" });
    }

    // 3. Hash password
    const hashedPassword = await bcrypt.hash(password, 10);

    // 4. Insert user
    const newUser = await pool.query(
      `INSERT INTO users (full_name, email, password, role)
       VALUES ($1, $2, $3, $4)
       RETURNING id, full_name, email`,
      [fullName, email, hashedPassword, "user"]
    );

    const user = newUser.rows[0];

    // 5. Generate tokens (FIXED TYPO HERE)
    const accessToken = generateAccessToken(user);
    const refreshToken = generateRefreshToken(user.id);

    // 6. Set refresh token cookie
    res.cookie("refreshToken", refreshToken, {
      httpOnly: true,
      secure: process.env.NODE_ENV === "production",
      sameSite: "lax",
      maxAge: 7 * 24 * 60 * 60 * 1000, // 7 days
      path: "/auth/refresh",
    });
const User={id:user.rows[0].id,full_name:user.rows[0].full_name,email:user.rows[0].email}
    // 7. Return response
    return res.status(201).json({
      message: "User registered successfully",
      user:User,
      accessToken,
    });

  } catch (error) {
    console.error("Error registering user:", error);
    return res.status(500).json({ message: "Internal server error" });
  }
};

export const getUserById = async (req: Request, res: Response) => {
  const { id } = req.params;

  try {
    if (!id) {
      return res.status(400).json({ message: "User ID is required" });
    }

    const user = await pool.query(
      "SELECT id, full_name, email FROM users WHERE id = $1",
      [id]
    );

    if (user.rows.length === 0) {
      return res.status(404).json({ message: "User not found" });
    }

    return res.status(200).json({
      user: user.rows[0]
    });

  } catch (error) {
    console.error("Error fetching user:", error);
    return res.status(500).json({ message: "Internal server error" });
  }
};


export const updateUser = async (req: Request, res: Response) => {
  const { id } = req.params;
  const { fullName, email } = req.body;

  try {
    if (!id) {
      return res.status(400).json({ message: "User ID is required" });
    }

    if (!fullName && !email) {
      return res.status(400).json({ message: "At least one field is required to update" });
    }

  
    const user = await pool.query(
      "SELECT id, full_name, email FROM users WHERE id = $1",
      [id]
    );

    if (user.rows.length === 0) {
      return res.status(404).json({ message: "User not found" });
    }

    const existingUser = user.rows[0];

   
    const userUpdated = await pool.query(
      `UPDATE users 
       SET full_name = $1, email = $2
       WHERE id = $3
       RETURNING id, full_name, email`,
      [
        fullName || existingUser.full_name,
        email || existingUser.email,
        id
      ]
    );

    return res.status(200).json({
      message: "User updated successfully",
      user: userUpdated.rows[0]
    });

  } catch (error) {
    console.error("Error updating user:", error);
    return res.status(500).json({ message: "Internal server error" });
  }
};
    

  export  const deleteUser=async(req:Request,res:Response)=>{
        const {id}=req.params;  
        try{
            if(!id){
                return res.status(400).json({message:"User ID is required"})
            }
            const user=await pool.query("SELECT * FROM users WHERE id=$1",[id]);
            if(user.rows.length===0){
                return res.status(404).json({message:"User not found"})
            }
            await pool.query("DELETE FROM users WHERE id=$1",[id]);
            return res.status(200).json({message:"User deleted successfully"})
        }catch(error){
            console.error("Error deleting user:",error);
            return res.status(500).json({message:"Internal server error"})
        }}



export const logInUser = async (req: Request, res: Response) => {
  const { email, password } = req.body;

  try {
  
    if (!email || !password) {
      return res.status(400).json({ message: "Email and password are required" });
    }

  
    const user = await pool.query(
      "SELECT id, full_name, email, password, role FROM users WHERE email = $1",
      [email]
    );

    if (user.rows.length === 0) {
      return res.status(400).json({ message: "Invalid email or password" });
    }

    const dbUser = user.rows[0];

    
    const validPassword = await bcrypt.compare(password, dbUser.password);

    if (!validPassword) {
      return res.status(400).json({ message: "Invalid email or password" });
    }

   
    const payload = {
      id: dbUser.id,
      full_name: dbUser.full_name,
      email: dbUser.email,
      role: dbUser.role,
    };

   
    const accessToken = generateAccessToken(payload);
    const refreshToken = generateRefreshToken(payload.id);

   
    res.cookie("refreshToken", refreshToken, {
      httpOnly: true,
      secure: process.env.NODE_ENV === "production",
      sameSite: "lax",
      maxAge: 7 * 24 * 60 * 60 * 1000,
      path: "/auth/refresh",
    });

   
    return res.status(200).json({
      message: "Login successful",
      user: {
        id: dbUser.id,
        full_name: dbUser.full_name,
        email: dbUser.email,
        role: dbUser.role,
      },
      accessToken,
    });

  } catch (error) {
    console.error("Error logging in user:", error);
    return res.status(500).json({ message: "Internal server error" });
  }
};


export const refreshToken = async (req: Request, res: Response) => {
  const refreshToken = req.cookies.refreshToken;

  if (!refreshToken) {
    return res.status(401).json({ message: "Refresh token not found" });
  }

  try {
    // 1. VERIFY refresh token (use REFRESH_SECRET!)
    const decoded = jwt.verify(
      refreshToken,
      process.env.REFRESH_SECRET!
    ) as { id: number };

    // 2. Check user still exists
    const user = await pool.query(
      "SELECT id, full_name, email, role FROM users WHERE id = $1",
      [decoded.id]
    );

    if (user.rows.length === 0) {
      return res.status(404).json({ message: "User not found" });
    }

    const dbUser = user.rows[0];

    const payload = {
      id: dbUser.id,
      full_name: dbUser.full_name,
      email: dbUser.email,
      role: dbUser.role,
    };

    // 3. Generate new tokens
    const newAccessToken = generateAccessToken(payload);


  

    // . Send access token in response
    return res.status(200).json({
      accessToken: newAccessToken,
    });

  } catch (error) {
    console.error("Error refreshing token:", error);
    return res.status(401).json({ message: "Invalid refresh token" });
  }
};