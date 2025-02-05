import React from "react";
import { Link } from "react-router-dom";
import "bootstrap/dist/css/bootstrap.min.css";

const Home = () => {
    return (
        <div className="vw-100 vh-100 d-flex align-items-center justify-content-center bg-light">
            <div className="container text-center p-5 border rounded shadow bg-white">
                <h1 className="display-4 text-primary">Project Management System</h1>
                <p className="lead text-secondary mt-3">
                    Efficiently track projects, assign tasks, and collaborate seamlessly.
                </p>
                <hr className="my-4" />
                <div className="d-flex justify-content-center gap-3">
                    <Link to="/login" className="btn btn-primary btn-lg">
                        Log In
                    </Link>
                    <Link to="/projects" className="btn btn-primary btn-lg">
                        Projects
                    </Link>
                </div>
            </div>
        </div>
    );
};

export default Home;
