import React from "react";

//Importing Hooks
import { useState } from "react";

//Material UI imports
import { Typography, TextField, Button, Box } from "@mui/material";
import { Container } from "@mui/system";

//Material Icons
import GoogleIcon from "@mui/icons-material/Google";
import FacebookIcon from "@mui/icons-material/Facebook";
//FireBase imports
import { auth } from "../firebase-config";
import {
  createUserWithEmailAndPassword,
  signInWithEmailAndPassword,
  onAuthStateChanged,
  signOut,
} from "firebase/auth";

import {
  FacebookAuthProvider,
  GoogleAuthProvider,
  signInWithPopup,
} from "firebase/auth";

const LoginPage = () => {
  //Firebase functions for user login/register/logout

  const [registerEmail, setRegisterEmail] = useState("");
  const [registerPassword, setRegisterPassword] = useState("");
  const [loginEmail, setLoginEmail] = useState("");
  const [loginPassword, setLoginPassword] = useState("");

  const [user, setUser] = useState({});

  onAuthStateChanged(auth, (currentUser) => {
    setUser(currentUser);
  });

  const register = async () => {
    try {
      const user = await createUserWithEmailAndPassword(
        auth,
        registerEmail,
        registerPassword
      );
      console.log(user);
    } catch (error) {
      console.log(error.message);
    }
  };

  const login = async () => {
    try {
      const user = await signInWithEmailAndPassword(
        auth,
        loginEmail,
        loginPassword
      );
      console.log(user);
    } catch (error) {
      console.log(error.message);
    }
  };

  const logout = async () => {
    await signOut(auth);
  };

  const provider = new GoogleAuthProvider();

  const signInWithGoogle = () => {
    signInWithPopup(auth, provider)
      .then((result) => {
        const name = result.user.displayName;
        const email = result.user.email;
        const profilePic = result.user.photoURL;

        localStorage.setItem("name", name);
        localStorage.setItem("email", email);
        localStorage.setItem("profilePic", profilePic);
      })
      .catch((error) => {
        console.log(error);
      });
  };

  const signInWithFacebook = () => {
    const provider = new FacebookAuthProvider();
    signInWithPopup(auth, provider)
      .then((result) => {
        // const name = result.user.displayName;
        // const email = result.user.email;
        // localStorage.setItem("name", name);
        // localStorage.setItem("email", email);
      })
      .catch((error) => {
        console.log(error);
      });
  };

  return (
    <div>
      <Container maxWidth='sm'>
        <Typography margin='25px' variant='h2' align='center'>
          Login
        </Typography>
        <TextField
          fullWidth={true}
          align='center'
          id='outlined-basic'
          label='Email'
          variant='outlined'
          value={loginEmail}
          onChange={(event) => {
            setLoginEmail(event.target.value);
          }}
        />

        <TextField
          margin='normal'
          fullWidth={true}
          align='center'
          id='outlined-basic'
          label='Password'
          variant='outlined'
          value={loginPassword}
          onChange={(event) => {
            setLoginPassword(event.target.value);
          }}
        />
        <Box textAlign='center' pt={3}>
          <Button
            variant='outlined'
            align='center'
            size='large'
            fullWidth={true}
            onClick={login}
          >
            Login with Email
          </Button>
          <Box textAlign='center' pt={1.5}>
            <Button
              variant='outlined'
              align='center'
              size='large'
              fullWidth={true}
              endIcon={<GoogleIcon />}
              onClick={signInWithGoogle}
            >
              Login with Google
            </Button>
          </Box>
          <Box textAlign='center' pt={1.5}>
            <Button
              variant='outlined'
              align='center'
              size='large'
              fullWidth={true}
              endIcon={<FacebookIcon />}
              onClick={signInWithFacebook}
            >
              Login with Facebook
            </Button>
          </Box>
        </Box>

        <Typography margin='25px' variant='h2' align='center'>
          Sign Up
        </Typography>
        <TextField
          fullWidth={true}
          align='center'
          id='outlined-basic'
          label='Email'
          variant='outlined'
          value={registerEmail}
          onChange={(event) => {
            setRegisterEmail(event.target.value);
          }}
        />

        <TextField
          margin='normal'
          fullWidth={true}
          align='center'
          id='outlined-basic'
          label='Password'
          variant='outlined'
          value={registerPassword}
          onChange={(event) => {
            setRegisterPassword(event.target.value);
          }}
        />

        <Box textAlign='center'>
          <Button
            variant='outlined'
            align='center'
            size='large'
            fullWidth={true}
            onClick={register}
          >
            Create Account
          </Button>
        </Box>

        <h4> User Logged In: </h4>
        {user?.email}

        <button onClick={logout}> Sign Out </button>
      </Container>
    </div>
  );
};

export default LoginPage;
