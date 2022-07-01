import React from "react";
import { Typoraphy, List, Button, Box } from "@mui/material";
import { getDoc, doc, deleteDoc } from "@firebase/firestore";
import { useUserAuth } from "../context/UserAuthContext";
import { db } from "../firebase-config";

const NotesNav = ({
  notesTitle,
  notesNote,
  setNotesTitle,
  setNotesInput,
  id,
}) => {
  const { user } = useUserAuth();
  const showTodo = async () => {
    // const notes = await getDoc(doc(db, `users/${user.uid}/notes`, id));

    console.log(notesNote);
    setNotesInput(notesNote);
    setNotesTitle(notesTitle);
  };
  async function deleteTodo() {
    deleteDoc(doc(db, `users/${user.uid}/notes`, id));
  }

  return (
    <>
      <List>
        <Box textAlign='center'>
          <Button onClick={showTodo}>{notesTitle}</Button>
        </Box>
      </List>
    </>
  );
};

export default NotesNav;
