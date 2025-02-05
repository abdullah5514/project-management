import React, { useState, useEffect } from "react";
import axios from "axios";

const ProjectList = () => {
  const [projects, setProjects] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  // Fetch projects from Rails API
  useEffect(() => {
    axios
      .get("/api/v1/projects")
      .then((response) => {
        setProjects(response.data);  // Save fetched data to state
        setLoading(false);            // Stop loading
      })
      .catch((err) => {
        setError(err);                // Handle error
        setLoading(false);
      });
  }, []);

  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error.message}</div>;

  return (
    <div>
      <h2>Project List</h2>
      <ul>
      {projects.map((project) => (
          <li key={project.id}>{project.name}</li> // Adjust according to your data structure
        ))}
      </ul>
    </div>
  );
};

export default ProjectList;
