import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import axios from "axios";

const Login = () => {
    const [email, setEmail] = useState("");
    const [password, setPassword] = useState("");
    const [error, setError] = useState(null);
    const navigate = useNavigate();

    const handleLogin = async (e) => {
        e.preventDefault();
        try {
            const response = await axios.post("/api/v1/login", { email, password });
            localStorage.setItem("token", response.data.token);
            localStorage.setItem("role", response.data.user.role);
            navigate("/projects");
        } catch (err) {
            setError("Invalid credentials, please try again.");
        }
    };

    return (
        <div className="vw-100 vh-100 d-flex align-items-center justify-content-center">
            <div className="container p-4 border rounded shadow bg-white text-center">
                <h2 className="mb-4">Login</h2>
                {error && <p className="text-danger">{error}</p>}
                <form onSubmit={handleLogin}>
                    <div className="mb-3">
                        <input type="email" className="form-control" placeholder="Email" value={email} onChange={(e) => setEmail(e.target.value)} required />
                    </div>
                    <div className="mb-3">
                        <input type="password" className="form-control" placeholder="Password" value={password} onChange={(e) => setPassword(e.target.value)} required />
                    </div>
                    <button type="submit" className="btn btn-primary">Login</button>
                </form>
            </div>
        </div>
    );
};

export default Login;
