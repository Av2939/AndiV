import React, { useState, useEffect } from "react";

//Importing Components

import { useUserAuth } from "../context/UserAuthContext";
import {
  doc,
  setDoc,
  getDocs,
  onSnapshot,
  collection,
  serverTimestamp,
  addDoc,
} from "firebase/firestore";
import { db } from "../firebase-config";
//////////////////////////////////////////
import { TextField, Button, Box } from "@mui/material";
import AddBoxIcon from "@mui/icons-material/AddBox";
import TodoListItem from "./Todo";
import { IconButton } from "@mui/material";

const TodoContainer = () => {
  const [todos, setTodos] = useState([]);
  const [todoInput, setTodoInput] = useState("");
  const { user } = useUserAuth();

  useEffect(() => {
    getTodos();
  }, []); // blank to run only on first launch

  function getTodos() {
    onSnapshot(
      collection(db, `users/${user.uid}/reminders`),
      function (querySnapshot) {
        setTodos(
          querySnapshot.docs.map((doc) => ({
            id: doc.id,
            todo: doc.data().todo,
            inprogress: doc.data().inprogress,
          }))
        );
      }
    );
    // console.log(todos);
  }

  async function addTodo(e) {
    e.preventDefault();
    const docRef = doc(db, "users", user.uid);
    const colRef = collection(docRef, "reminders");
    await addDoc(colRef, {
      inprogress: true,
      timestamp: serverTimestamp(),
      todo: todoInput,
    });

    setTodoInput("");
  }

  return (
    <div className='App'>
      <div
        style={{
          display: "flex",
          flexDirection: "column",
          justifyContent: "center",
          alignItems: "center",
          width: "100%",
        }}
      >
        <form>
          <Box paddingTop={3}>
            <TextField
              id='standard-basic'
              label='Remind me to...'
              value={todoInput}
              style={{ width: "90vw", maxWidth: "500px" }}
              onChange={(e) => setTodoInput(e.target.value)}
            />

            <IconButton
              type='submit'
              // variant='contained'
              onClick={addTodo}
              style={{ color: "teal" }}
              // size='small'
              sx={{
                // outline: "solid",
                color: "teal",
                marginLeft: "-2px",
                marginTop: "-9px",
              }}
            >
              <AddBoxIcon sx={{ color: "teal", fontSize: "55px" }} />
            </IconButton>
          </Box>
        </form>

        <div style={{ width: "90vw", maxWidth: "500px", marginTop: "24px" }}>
          {todos.map((todo) => (
            <TodoListItem
              todo={todo.todo}
              inprogress={todo.inprogress}
              id={todo.id}
            />
          ))}
        </div>
      </div>
    </div>
  );
};

export default TodoContainer;
