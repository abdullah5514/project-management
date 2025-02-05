import React, { useState, useEffect } from "react";
import axios from "axios";
import { useParams } from "react-router-dom";
import "bootstrap/dist/css/bootstrap.min.css";
import { getToken } from "../utils/auth";

const ProjectBreakdown = () => {
    const { id } = useParams(); // Getting the project id from the URL
    const [project, setProject] = useState(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [taskName, setTaskName] = useState("");
    const [taskDescription, setTaskDescription] = useState("");
    const [taskStartTime, setTaskStartTime] = useState("");
    const [taskEndTime, setTaskEndTime] = useState("");
    const token = getToken();

    // Function to fetch project data
    const fetchProjectData = () => {
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
    };

    // Fetch project data when component mounts or id changes
    useEffect(() => {
        fetchProjectData();
    }, [id, token]);

    // Handle form submission to add a new task
    const handleAddTask = (e) => {
        e.preventDefault();

        const newTask = {
            name: taskName,
            description: taskDescription,
            start_time: taskStartTime,
            end_time: taskEndTime,
        };

        axios
            .post(
                "/api/v1/tasks",
                { task: newTask, project_id: id },
                { headers: { Authorization: `Bearer ${token}` } }
            )
            .then(() => {
                // Refetch the updated project breakdown details after adding the task
                fetchProjectData();

                // Clear the form fields
                setTaskName("");
                setTaskDescription("");
                setTaskStartTime("");
                setTaskEndTime("");
            })
            .catch((err) => {
                setError(err);
            });
    };

    if (loading) return <div className="text-center mt-5">Loading...</div>;
    if (error) return <div className="text-danger text-center mt-5">Error: {error.message}</div>;

    return (
        <div className="container mt-5">
            <h2 className="text-center text-primary">{project.project}</h2>

            {/* Task Breakdown */}
            <ul className="list-group mt-3">
                {project.tasks.map((task, index) => (
                    <li key={index} className="list-group-item">
                        <strong>{task.name}</strong> - {task.duration} <br />
                        <span className="text-muted">{task.time_range}</span>
                    </li>
                ))}
            </ul>

            <h4 className="mt-3 text-center">Total Time on Tasks: {project.total_hours}</h4>

            {/* Add Task Form */}
            <div className="mt-4">
                <h5>Add a New Task</h5>
                <form onSubmit={handleAddTask}>
                    <div className="form-group">
                        <label htmlFor="taskName">Task Name</label>
                        <input
                            type="text"
                            className="form-control"
                            id="taskName"
                            value={taskName}
                            onChange={(e) => setTaskName(e.target.value)}
                            required
                        />
                    </div>
                    <div className="form-group">
                        <label htmlFor="taskDescription">Task Description</label>
                        <textarea
                            className="form-control"
                            id="taskDescription"
                            value={taskDescription}
                            onChange={(e) => setTaskDescription(e.target.value)}
                            required
                        />
                    </div>
                    <div className="form-group">
                        <label htmlFor="taskStartTime">Start Time</label>
                        <input
                            type="datetime-local"
                            className="form-control"
                            id="taskStartTime"
                            value={taskStartTime}
                            onChange={(e) => setTaskStartTime(e.target.value)}
                            required
                        />
                    </div>
                    <div className="form-group">
                        <label htmlFor="taskEndTime">End Time</label>
                        <input
                            type="datetime-local"
                            className="form-control"
                            id="taskEndTime"
                            value={taskEndTime}
                            onChange={(e) => setTaskEndTime(e.target.value)}
                            required
                        />
                    </div>
                    <button type="submit" className="btn btn-primary mt-3">
                        Add Task
                    </button>
                </form>
            </div>

            {/* Assigned Users Section */}
            {project.assigned_users.length > 0 && (
                <div className="mt-4">
                    <h5>Assigned Users:</h5>
                    <ul>
                        {project.assigned_users.map((user) => (
                            <li key={user.id}>{user.name}</li>
                        ))}
                    </ul>
                </div>
            )}
        </div>
    );
};

export default ProjectBreakdown;
