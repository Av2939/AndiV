// import { initializeApp } from "firebase/app";
// import { getAuth } from "firebase/auth";
// // TODO: Add SDKs for Firebase products that you want to use
// import { getFirestore } from "@firebase/firestore"; // TODO: Add SDKs for Firebase products that you want to use
// // https://firebase.google.com/docs/web/setup#available-libraries

// // Your web app's Firebase configuration
// @ -20,3 +20,4 @@ const firebaseConfig = {
// const app = initializeApp(firebaseConfig);

// export const auth = getAuth(app);
// export const db = getFirestore(app);

// ____________________________________________________________________________________________________________________________________________________________

// import { auth, db } from "./firebase-config";
// import {
//   doc,
//   setDoc,
//   Timestamp,
//   getDoc,
//   collection,
//   serverTimestamp,
// } from "firebase/firestore";
// import "firebase/firestore";

// const register = async () => {
//     try {
//       const user = await createUserWithEmailAndPassword(
//       const res = await createUserWithEmailAndPassword(
//         auth,
//         registerEmail,
//         registerPassword
//       );
//       console.log(user);
//       userToDB(res);
//     } catch (error) {
//       console.log(error.message);
//     }
// @ -50,6 +60,25 @@ function App() {
//     await signOut(auth);
//   };

//     // const docData = {
//   //   email: `${user?.email}`,
//   // };
//   const userToDB = async (res) => {
//     await setDoc(doc(db, "users", `${res.user.uid}`), {
//       name: "Big Cock tings",
//       timeStamp: serverTimestamp(),
//       UID: res.user.uid,
//       email: res.user.email,
//     });
//     const docSnap = await getDoc(doc(db, "users", `${res.user.uid}`));
//     if (docSnap.exists()) {
//       console.log("Document data:", docSnap.data());
//     } else {
//       // doc.data() will be undefined in this case
//       console.log("No such document!");
//     }
//   };

//   return (
