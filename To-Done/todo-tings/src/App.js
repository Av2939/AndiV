// import { Home } from "@mui/icons-material";
import React from "react";

import HomePage from "./homeComponents/HomePage";
import MainPage from "./mainpageComponents/MainPage";

import { UserAuthContextProvider } from "./context/UserAuthContext";
// import { FirebaseDataProvider } from "../Maybe_Reusable code/fireBaseData";

import ProtectedRoute from "./ProtectedRoutes";

import { BrowserRouter as Router, Routes, Route } from "react-router-dom";

function App() {
  return (
    <Router>
      <UserAuthContextProvider>
        {/* <FirebaseDataProvider> */}
        <Routes>
          <Route path='/' element={<HomePage />} />
          <Route
            path='/mainpage'
            element={
              <ProtectedRoute>
                <MainPage />
              </ProtectedRoute>
            }
          />
          {/* <Route
            path='/notes'
            element={
              <ProtectedRoute>
                <Notes />
              </ProtectedRoute>
            }
          />
          <Route
            path='/reminders'
            element={
              <ProtectedRoute>
                <Reminders />
              </ProtectedRoute>
            }
          /> */}
        </Routes>
        {/* </FirebaseDataProvider> */}
      </UserAuthContextProvider>
    </Router>
  );
}

export default App;
