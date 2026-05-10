import {registerUser,logInUser,refreshToken,getUserById,updateUser} from "./auth.controller.js"
import {Router} from "express";

const router=Router();

router.post("/user",registerUser);
router.post("/login",logInUser);
router.post("/refresh",refreshToken);
router.get("/user/:id",getUserById);
router.put("/user/:id",updateUser);

export default router;