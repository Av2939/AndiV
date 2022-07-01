import React from "react";

//Material UI imports
import { TextField, Button, Box } from "@mui/material";
import { Container } from "@mui/system";

//Material Icons
import GoogleIcon from "@mui/icons-material/Google";
import AccountBoxRoundedIcon from "@mui/icons-material/AccountBoxRounded";
import { useNavigate } from "react-router-dom";
import { useState } from "react";
import { useUserAuth } from "../context/UserAuthContext";
import { doc, setDoc } from "firebase/firestore";
import { db } from "../firebase-config";

const SignIn = () => {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const { logIn, googleSignIn, anonymouslySignIn } = useUserAuth();

  const navigate = useNavigate();

  function addUser(res) {
    setDoc(
      doc(db, "users", `${res.user.uid}`),

      { merge: true }
    );
  }

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const res = await logIn(email, password);
      await addUser(res);
      navigate("/mainpage");
    } catch (err) {
      console.log(err.message);
    }
  };

  const handleGoogleSignIn = async () => {
    try {
      const res = await googleSignIn();
      addUser(res);
      navigate("/mainpage");
    } catch (err) {}
  };
  const handleAnonSignIn = async (e) => {
    e.preventDefault();
    try {
      await anonymouslySignIn(email, password);
      navigate("/mainpage");
    } catch (err) {
      console.log(err.message);
    }
  };

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
          type='password'
          variant='outlined'
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
            Login with Email
          </Button>
          <Box textAlign='center' pt={1.5}>
            <Button
              variant='outlined'
              align='center'
              size='large'
              fullWidth={true}
              endIcon={<GoogleIcon />}
              onClick={handleGoogleSignIn}
              sx={{ color: "teal", borderColor: "teal" }}
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
              endIcon={<AccountBoxRoundedIcon />}
              onClick={handleAnonSignIn}
              sx={{ color: "teal", borderColor: "teal" }}
            >
              LOGIN Anonymously
            </Button>
          </Box>
        </Box>
      </Container>
    </div>
  );
};

export default SignIn;
