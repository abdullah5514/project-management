import React from "react";
import { BrowserRouter as Router, Route, Routes, Navigate } from "react-router-dom";
import { isAuthenticated } from "../utils/auth";
import Home from "./Home";
import Login from "./Login";
import ProjectList from "./ProjectList";

const ProtectedRoute = ({ element }) => {
    return isAuthenticated() ? element : <Navigate to="/login" />;
};

const App = () => {
    return (
        <Router>
            <Routes>
                <Route path="/" element={!isAuthenticated() ? <Navigate to="/projects" /> : <Home /> } />
                <Route path="/login" element={!isAuthenticated() ? <Navigate to="/projects" /> : <Login /> } />
                <Route path="/projects" element={<ProtectedRoute element={<ProjectList />} />} />
            </Routes>
        </Router>
    );
};

export default App;
