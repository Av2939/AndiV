import React from "react";
import { ListItem, ListItemText, Button } from "@mui/material";
import { db } from "../firebase-config";
import { deleteDoc, doc, updateDoc } from "@firebase/firestore";
import { useUserAuth } from "../context/UserAuthContext";
export default function TodoListItem({ todo, inprogress, id }) {
  const { user } = useUserAuth();
  async function toggleInProgress() {
    await updateDoc(doc(db, `users/${user.uid}/reminders`, id), {
      inprogress: !inprogress,
    });
    console.log(user.uid);
  }

  async function deleteTodo() {
    deleteDoc(doc(db, `users/${user.uid}/reminders`, id));
  }

  return (
    <div style={{ display: "flex" }}>
      <ListItem>
        <ListItemText
          primary={todo}
          secondary={inprogress ? "In Progress" : "Completed"}
        />
      </ListItem>

      <Button onClick={toggleInProgress}>
        {inprogress ? "Done" : "UnDone"}
      </Button>
      <Button onClick={deleteTodo}>X</Button>
    </div>
  );
}
