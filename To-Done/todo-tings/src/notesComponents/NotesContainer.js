import React, { useState, useEffect } from "react";
import Grid from "@mui/material/Grid";
import { Paper, Box, Button } from "@mui/material";
import {
  doc,
  collection,
  onSnapshot,
  addDoc,
  serverTimestamp,
} from "@firebase/firestore";
import { useUserAuth } from "../context/UserAuthContext";
import { db } from "../firebase-config";
import NotesItem from "./NotesItem";
import NotesNav from "./NotesNav";

const NotesContainer = () => {
  const [notes, setNotes] = useState([]);
  const [notesTitle, setNotesTitle] = useState("");
  const [notesInput, setNotesInput] = useState("");
  const [currentTodo, setCurrentTodo] = useState("");
  const { user } = useUserAuth();

  useEffect(() => {
    getNotes();
  }, []); // blank to run only on first launch

  function getNotes() {
    onSnapshot(
      collection(db, `users/${user.uid}/notes`),
      function (querySnapshot) {
        setNotes(
          querySnapshot.docs.map((doc) => ({
            id: doc.id,
            note: doc.data().note,
            title: doc.data().title,
          }))
        );
      }
    );
  }

  async function addNote(e) {
    e.preventDefault();
    const docRef = doc(db, "users", user.uid);
    const colRef = collection(docRef, "notes");
    await addDoc(colRef, {
      timestamp: serverTimestamp(),
      note: notesInput,
      title: notesTitle,
    });

    setNotesInput("");
    setNotesTitle("");
  }
  const clearText = () => {
    setNotesInput("");
    setNotesTitle("");
  };

  return (
    <Grid container>
      <Grid item xs={12} md={2}>
        <Box paddingLeft={1} paddingY={3}>
          <Paper elevation={5}>
            <Box paddingX={1} paddingY={1} textAlign='center'>
              <Button variant='outlined' onClick={clearText}>
                Add New TODO +
              </Button>
            </Box>
            {notes.map((note) => (
              <NotesNav
                notesTitle={note.title}
                notesNote={note.note}
                setNotesInput={setNotesInput}
                setNotesTitle={setNotesTitle}
                setCurrentTodo={setCurrentTodo}
                id={note.id}
              />
              // console.log(title.title)
            ))}
          </Paper>
        </Box>
      </Grid>

      <Grid item xs={12} md={10}>
        <Box padding={3}>
          <Paper elevation={5}>
            <NotesItem
              addNote={addNote}
              setNotesInput={setNotesInput}
              notesInput={notesInput}
              notesTitle={notesTitle}
              setNotesTitle={setNotesTitle}
              currentTodo={currentTodo}
            />
          </Paper>
        </Box>
      </Grid>
    </Grid>
  );
};

export default NotesContainer;
