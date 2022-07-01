import React from "react";

import { List, Box, Button } from "@mui/material";
const NotesNav = ({
  notesTitle,
  notesNote,
  setNotesTitle,
  setNotesInput,
  id,
  setCurrentTodo,
}) => {
  const showTodo = async () => {
    setNotesInput(notesNote);
    setNotesTitle(notesTitle);
    setCurrentTodo(id);
  };

  return (
    <>
      <List>
        <Box textAlign='center'>
          <Button onClick={showTodo} sx={{ textDecoration: "underline" }}>
            {notesTitle}
          </Button>
        </Box>
      </List>
    </>
  );
};

export default NotesNav;
