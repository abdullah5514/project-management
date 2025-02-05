import React, { useState, useEffect } from "react";
import axios from "axios";
import { useParams } from "react-router-dom"; // Import useParams to get the id
import "bootstrap/dist/css/bootstrap.min.css";
import {getToken} from "../utils/auth";

const ProjectBreakdown = () => {
    const { id } = useParams();  // Using useParams to get the project id from the URL
    const [project, setProject] = useState(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const token = getToken();

    useEffect(() => {
        axios
            .get(`/api/v1/projects/${id}/task_breakdown`, { headers: { Authorization: `Bearer ${token}` } })
            .then((response) => {
                setProject(response.data);
                setLoading(false);
            })
            .catch((err) => {
                setError(err);
                setLoading(false);
            });
    }, [id, token]);

    if (loading) return <div className="text-center mt-5">Loading...</div>;
    if (error) return <div className="text-danger text-center mt-5">Error: {error.message}</div>;

    return (
        <div className="container mt-5">
            <h2 className="text-center text-primary">{project.project}</h2>
            <ul className="list-group mt-3">
                {project.tasks.map((task, index) => (
                    <li key={index} className="list-group-item">
                        <strong>{task.name}</strong> - {task.duration} <br />
                        <span className="text-muted">{task.time_range}</span>
                    </li>
                ))}
            </ul>
            <h4 className="mt-3 text-center">Total Time on Tasks: {project.total_hours}</h4>
        </div>
    );
};

export default ProjectBreakdown;
