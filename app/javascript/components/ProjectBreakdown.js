import React, { useState, useEffect } from "react";
import axios from "axios";
import { useParams } from "react-router-dom";
import "bootstrap/dist/css/bootstrap.min.css";
import {getToken} from "../utils/auth";

const ProjectBreakdown = () => {
    const { id } = useParams();  // Getting the project id from the URL
    const [project, setProject] = useState(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const token = getToken();

    useEffect(() => {
        // Fetching the project data when component mounts
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

    // Function to assign a user to the project
    const handleAssign = (userId, userName) => {
        axios
            .post(
                `/api/v1/projects/${id}/assign`,
                { user_id: userId },
                { headers: { Authorization: `Bearer ${token}` } }
            )
            .then((response) => {
                // Update the project state to reflect the new user assignment
                setProject((prevProject) => ({
                    ...prevProject,
                    assigned_users: [...prevProject.assigned_users, { id: userId, name: userName }], // Add the user to assigned
                    available_users: prevProject.available_users.filter(
                        (user) => user.id !== userId
                    ), // Remove from available
                }));
            })
            .catch((err) => {
                setError(err);
            });
    };

    // Function to unassign a user from the project
    const handleUnassign = (userId, userName) => {
        axios
            .delete(
                `/api/v1/projects/${id}/unassign`,
                { headers: { Authorization: `Bearer ${token}` }, data: { user_id: userId } }
            )
            .then((response) => {
                // Update the project state to reflect the user removal
                setProject((prevProject) => ({
                    ...prevProject,
                    assigned_users: prevProject.assigned_users.filter((user) => user.id !== userId), // Remove from assigned
                    available_users: [
                        ...prevProject.available_users,
                        { id: userId, name: userName },
                    ], // Add back to available
                }));
            })
            .catch((err) => {
                setError(err);
            });
    };

    if (loading) return <div className="text-center mt-5">Loading...</div>;
    if (error) return <div className="text-danger text-center mt-5">Error: {error.message}</div>;

    return (
        <div className="container mt-5">
            <h2 className="text-center text-primary">{project.project_name}</h2>
            <ul className="list-group mt-3">
                {project.tasks.map((task, index) => (
                    <li key={index} className="list-group-item">
                        <strong>{task.name}</strong> - {task.duration} <br />
                        <span className="text-muted">{task.time_range}</span>
                    </li>
                ))}
            </ul>

            <h4 className="mt-3 text-center">Total Time on Tasks: {project.total_hours}</h4>

            {/* Assigned Users Section */}
            {project.assigned_users.length > 0 && (
                <div className="mt-4">
                    <h5>Assigned Users:</h5>
                    <ul>
                        {project.assigned_users.map((user) => (
                            <li key={user.id}>
                                {user.name}
                                <button
                                    onClick={() => handleUnassign(user.id, user.name)}
                                    className="btn btn-danger btn-sm ml-2"
                                >
                                    Unassign
                                </button>
                            </li>
                        ))}
                    </ul>
                </div>
            )}

            {/* Available Users Section */}
            {project.available_users.length > 0 && (
                <div className="mt-4">
                    <h5>Available Users:</h5>
                    <ul>
                        {project.available_users.map((user) => (
                            <li key={user.id}>
                                {user.name}
                                <button
                                    onClick={() => handleAssign(user.id, user.name)}
                                    className="btn btn-success btn-sm ml-2"
                                >
                                    Assign
                                </button>
                            </li>
                        ))}
                    </ul>
                </div>
            )}
        </div>
    );
};

export default ProjectBreakdown;
