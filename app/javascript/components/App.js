import React from "react";
import { BrowserRouter as Router, Route, Routes, Navigate } from "react-router-dom";
import {getUserRole, isAuthenticated} from "../utils/auth";
import Home from "./Home";
import Layout from "./Layout";
import Login from "./Login";
import ProjectList from "./ProjectList";
import UserProjectList from "./UserProjectList";
import ProjectBreakdown from "./ProjectBreakdown";
import UserProjectBreakdown from "./UserProjectBreakdown";

const ProtectedRoute = ({ element }) => {
    return isAuthenticated() ? <Layout>{element}</Layout> : <Navigate to="/login" />;
};

const App = () => {
    const userRole = getUserRole();
    return (
        <Router>
            <Routes>
                <Route
                    path="/"
                    element={
                        (isAuthenticated() && userRole !== null) ? (
                            userRole === "user" ? (
                                <Navigate to="/my-projects" /> // Redirect user to their own projects
                            ) : (
                                <Navigate to="/projects" /> // Redirect admin to all projects
                            )
                        ) : (
                            <Home /> // Non-authenticated user goes to Home
                        )
                    }
                />
                <Route
                    path="/login"
                    element={(isAuthenticated() && userRole !== null) ? (
                        userRole === "user" ? (
                            <Navigate to="/my-projects" />
                        ) : (
                            <Navigate to="/projects" />
                        )
                    ) : (
                        <Login /> // Non-authenticated user goes to Login
                    )}
                />

                <Route path="/projects" element={<ProtectedRoute element={<ProjectList />} />} />
                <Route path="/projects/:id" element={<ProtectedRoute element={<ProjectBreakdown />} />} />
                <Route path="/my-projects" element={<ProtectedRoute element={<UserProjectList />} />} />
                <Route path="/my-projects/:id" element={<ProtectedRoute element={<UserProjectBreakdown />} />} />
            </Routes>
        </Router>
    );
};

export default App;
