import React from "react";
import { Link } from "react-router-dom";
import { isAuthenticated, getUserRole } from "../utils/auth";
import "bootstrap/dist/css/bootstrap.min.css";

const Layout = ({ children }) => {
    const handleLogout = async () => {
        try {
            const token = localStorage.getItem("token");

            const response = await fetch("/api/v1/logout", {
                method: "DELETE",
                headers: {
                    "Content-Type": "application/json",
                    Authorization: `Bearer ${token}`,
                },
            });

            if (response.ok) {
                localStorage.clear();
                window.location.href = "/login";
            } else {
                console.error("Logout failed");
            }
        } catch (error) {
            console.error("Error during logout:", error);
        }
    };

    return (
        <>
            {/* Bootstrap Navbar */}
            <nav className="navbar navbar-expand-lg navbar-dark bg-primary">
                <div className="container-fluid">
                    <Link className="navbar-brand" to="/">
                        Project Manager
                    </Link>
                    <button
                        className="navbar-toggler"
                        type="button"
                        data-bs-toggle="collapse"
                        data-bs-target="#navbarNav"
                        aria-controls="navbarNav"
                        aria-expanded="false"
                        aria-label="Toggle navigation"
                    >
                        <span className="navbar-toggler-icon"></span>
                    </button>
                    <div className="collapse navbar-collapse" id="navbarNav">
                        <ul className="navbar-nav ms-auto">
                            {isAuthenticated() ? (
                                <>
                                    <li className="nav-item">
                                        <Link
                                            className="nav-link"
                                            to={getUserRole() === "user" ? "/my-projects" : "/projects"}
                                        >
                                            Projects
                                        </Link>
                                    </li>
                                    <li className="nav-item">
                                        <button className="btn btn-danger ms-2" onClick={handleLogout}>
                                            Logout
                                        </button>
                                    </li>
                                </>
                            ) : (
                                <li className="nav-item">
                                    <Link className="nav-link" to="/login">
                                        Login
                                    </Link>
                                </li>
                            )}
                        </ul>
                    </div>
                </div>
            </nav>

            <div className="container mt-4">{children}</div>
        </>
    );
};

export default Layout;
