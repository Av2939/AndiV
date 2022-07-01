import React from "react";
import { useState } from "react";
import { useUserAuth } from "../context/UserAuthContext";
import { db } from "../firebase-config";
import { doc, getDoc } from "firebase/firestore";
import Header from "./Header";
import TodoContainer from "../remindersComponents/TodoContainer";
import NotesContainer from "../notesComponents/NotesContainer";

const MainPage = () => {
  const { user, logOut } = useUserAuth();
  const [value, setValue] = useState(0);

  const handleChange = (event, newValue) => {
    setValue(newValue);
  };
  const getTheData = async () => {
    const docRef = doc(db, `${user.uid}`, `${user.uid}`);
    const docSnap = await getDoc(docRef);

    if (docSnap.exists()) {
      console.log("Document data:", docSnap.data());
    } else {
      // doc.data() will be undefined in this case
      console.log("No such document!");
    }
  };
  const handleLogOut = async () => {
    try {
      await logOut();
    } catch (err) {
      console.log(err.message);
    }
  };
  return (
    <div>
      <Header
        handleLogOut={handleLogOut}
        handleChange={handleChange}
        value={value}
      />
      <div>{value === 0 ? <TodoContainer /> : <NotesContainer />}</div>

      {/* <button onClick={getTheData}>Click me</button>
      <h1>{user?.email}</h1>
      <h1>{user?.uid}</h1> */}
    </div>
  );
};

export default MainPage;
