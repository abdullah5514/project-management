import React, { useState, useEffect } from "react";
import axios from "axios";
import { getToken } from "../utils/auth";
import "bootstrap/dist/css/bootstrap.min.css";
import {Link} from "react-router-dom";

const ProjectList = () => {
    const [projects, setProjects] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const token = getToken();

    useEffect(() => {
        axios
            .get("/api/v1/users/assigned_projects", { headers: { Authorization: `Bearer ${token}` } })
            .then((response) => {
                setProjects(response.data);
                setLoading(false);
            })
            .catch((err) => {
                setError(err);
                setLoading(false);
            });
    }, [token]);

    if (loading) return <div className="text-center mt-5">Loading...</div>;
    if (error) return <div className="text-danger text-center mt-5">Error: {error.message}</div>;

    return (
        <div className="container mt-5">
            <h2 className="text-center text-primary">My Project List</h2>
            <div className="row justify-content-center">
                {projects.length > 0 ? (
                    projects.map((project) => (
                        <div key={project.id} className="col-md-4 mb-4">
                            <Link to={`/my-projects/${project.id}`} className="text-decoration-none">
                                <div className="card shadow-sm border-primary">
                                    <div className="card-body">
                                        <h5 className="card-title">{project.name}</h5>
                                        <p className="card-text">
                                            Start Date: {project.start_date} <br />
                                            Duration: {project.duration}
                                        </p>
                                    </div>
                                </div>
                            </Link>
                        </div>
                    ))
                ) : (
                    <p className="text-center text-muted">No projects available</p>
                )}
            </div>
        </div>
    );
};

export default ProjectList;
