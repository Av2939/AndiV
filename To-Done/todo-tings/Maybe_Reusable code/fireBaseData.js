// import { createContext, useState, useEffect, useContext } from "react";

// import { auth } from "../firebase-config";
// import { useUserAuth } from "../context/UserAuthContext";
// import { doc, setDoc, getDoc } from "firebase/firestore";
// import { db } from "../firebase-config";

// const userFirebaseData = createContext();

// export function FirebaseDataProvider({ children }) {
//   const { user } = useUserAuth();

//   function printHi() {
//     console.log("HI");
//   }
//   function addUser(res) {
//     setDoc(
//       doc(db, "users", `${res.user.uid}`),

//       { merge: true }
//     );
//   }

//   function addReminders(reminders) {
//     setDoc(doc(db, "users", `${user.uid}`), { Reminders: `${reminders}` });
//   }
//   async function readReminders() {
//     const docSnap = await getDoc(doc(db, "users", `${user.uid}`));
//     if (docSnap.exists()) {
//       console.log("Document data:", docSnap.data());
//     } else {
//       // doc.data() will be undefined in this case
//       console.log("No such document!");
//     }
//   }

//   return (
//     <userFirebaseData.Provider
//       value={{
//         printHi,
//         addUser,
//         addReminders,
//         readReminders,
//       }}
//     >
//       {children}
//     </userFirebaseData.Provider>
//   );
// }

// export function useFirebaseData() {
//   return useContext(userFirebaseData);
// }
