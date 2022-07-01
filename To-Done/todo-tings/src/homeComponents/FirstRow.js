import React from "react";
import { Typography } from "@mui/material";
//Importing Grid
import Grid from "@mui/material/Grid";
import { Box, styled } from "@mui/system";
import "./HomePage.css";
import LoginPage from "../signpageComponents/LoginPage";

const StyledBox = styled(
  Box,
  {}
)({
  // backgroundColor: "red",
  // color: "red;text-decoration:line-through",
});

const FirstRow = () => {
  return (
    <Box className='first-ting'>
      <Grid container>
        <Grid item xs={12} md={6}>
          <Box className='main-ting' textAlign='center'>
            <StyledBox marginLeft={-23}>
              <Typography variant='h1'>TO...</Typography>
            </StyledBox>
            <Box className='done-ting'>
              <Typography
                variant='h2'
                sx={{
                  textDecoration: "line-through",
                  textDecorationColor: "teal",
                  color: "#43474a",
                }}
              >
                Done
              </Typography>
            </Box>
          </Box>
        </Grid>
        <Grid item xs={12} md={6} paddingTop={4} paddingX={4}>
          <LoginPage />
        </Grid>
      </Grid>
    </Box>
  );
};

export default FirstRow;
