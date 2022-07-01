import React from "react";

//Material UI imports
import { TextField, Button, Box } from "@mui/material";
import { Container } from "@mui/system";

import { useNavigate } from "react-router-dom";
import { useState } from "react";
import { useUserAuth } from "../context/UserAuthContext";
import { doc, setDoc, getDoc } from "firebase/firestore";
import { db } from "../firebase-config";

const SignUp = () => {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");
  const { signUp } = useUserAuth();

  const navigate = useNavigate();

  function addUser(res) {
    setDoc(
      doc(db, "users", `${res.user.uid}`),

      { merge: true }
    );
  }
  const handleSubmit = async (e) => {
    e.preventDefault();
    setError("");
    try {
      const res = await signUp(email, password);
      addUser(res);
      navigate("/mainpage");
    } catch (err) {
      console.log(err.message);
    }
  };

  // const handleGoogleSignIn = async () => {
  //   try {
  //     await googleSignIn();
  //     navigate("/mainpage");
  //     printHi();
  //   } catch (err) {}
  // };
  // const signInWithFacebook = () => {
  //   const provider = new FacebookAuthProvider();
  //   signInWithPopup(auth, provider)
  //     .then((result) => {
  //       // const name = result.user.displayName;
  //       // const email = result.user.email;
  //       // localStorage.setItem("name", name);
  //       // localStorage.setItem("email", email);
  //     })
  //     .catch((error) => {
  //       console.log(error);
  //     });
  // };

  return (
    <div>
      <Container maxWidth='sm'>
        <Box paddingTop={5}>
          <TextField
            fullWidth={true}
            align='center'
            id='outlined-basic'
            label='Email'
            variant='outlined'
            value={email}
            onChange={(event) => {
              setEmail(event.target.value);
            }}
          />
        </Box>

        <TextField
          margin='normal'
          fullWidth={true}
          align='center'
          id='outlined-basic'
          label='Password'
          variant='outlined'
          type='password'
          value={password}
          onChange={(event) => {
            setPassword(event.target.value);
          }}
        />

        <Box textAlign='center' pt={3}>
          <Button
            variant='outlined'
            align='center'
            size='large'
            fullWidth={true}
            onClick={handleSubmit}
            sx={{ color: "teal", borderColor: "teal" }}
          >
            Create Account
          </Button>
        </Box>

        <Box textAlign='center' pt={1.5}>
          {/* <Box textAlign='center'>
            <Button
              variant='outlined'
              align='center'
              size='large'
              fullWidth={true}
              endIcon={<GoogleIcon />}
              onClick={handleGoogleSignIn}
              sx={{ color: "teal", borderColor: "teal" }}
            >
              SignUp with Google
            </Button>
          </Box>
          <Box textAlign='center' pt={1.5}>
            <Button
              variant='outlined'
              align='center'
              size='large'
              fullWidth={true}
              endIcon={<FacebookIcon />}
              // onClick={signInWithFacebook}
              sx={{ color: "teal", borderColor: "teal" }}
            >
              SignUp with Facebook
            </Button>
          </Box> */}
        </Box>
      </Container>
    </div>
  );
};

export default SignUp;
