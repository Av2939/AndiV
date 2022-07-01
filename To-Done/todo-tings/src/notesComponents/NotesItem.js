import React from "react";
import { TextField, Box, Button, Stack } from "@mui/material";
import { deleteDoc, doc } from "@firebase/firestore";
import { useUserAuth } from "../context/UserAuthContext";
import { db } from "../firebase-config";

const NotesItem = ({
  addNote,
  notesInput,
  setNotesInput,
  setNotesTitle,
  notesTitle,
  currentTodo,
}) => {
  const { user } = useUserAuth();

  async function deleteNote() {
    // db.collection("todos").doc(id).delete();
    deleteDoc(doc(db, `users/${user.uid}/notes`, currentTodo));
    setNotesInput("");
    setNotesTitle("");
  }

  return (
    <>
      <Box
        component='form'
        sx={{
          "& .MuiTextField-root": { m: 2, width: "90%" },
        }}
        noValidate
        autoComplete='off'
      >
        <TextField
          id='outlined-textarea'
          label='Title'
          value={notesTitle}
          onChange={(e) => setNotesTitle(e.target.value)}
          multiline
          variant='outlined'
          size='small'
        />
        <TextField
          id='standard-multiline-flexible'
          label='Note'
          placeholder='Take a note'
          multiline
          minRows={6}
          maxRows={10}
          value={notesInput}
          onChange={(e) => setNotesInput(e.target.value)}
          variant='outlined'
        />
        <Box padding={3}>
          <Stack spacing={2} direction='row'>
            <Button variant='outlined' color='primary' onClick={addNote}>
              SAVE
            </Button>

            <Button variant='outlined' color='primary' onClick={deleteNote}>
              DELETE
            </Button>
          </Stack>
        </Box>
      </Box>
    </>
  );
};

export default NotesItem;
