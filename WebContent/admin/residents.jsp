<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*,com.greenwatt.services.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Residents - GreenWatt</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=Poppins:wght@500;700&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Inter', sans-serif;
            background: #f9fafb;
            color: #1a1a1a;
        }

        .container {
            max-width: 1100px;
            margin: 3rem auto;
            padding: 2rem;
            background: #ffffff;
            border-radius: 1rem;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }

        h3 {
            font-family: 'Poppins', sans-serif;
            font-size: 2rem;
            font-weight: 700;
            text-align: center;
            margin-bottom: 2rem;
            background: linear-gradient(135deg, #22c55e, #3b82f6);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            overflow: hidden;
            border-radius: 0.75rem;
            box-shadow: 0 4px 15px rgba(34,197,94,0.1);
        }

        th {
            background: linear-gradient(135deg, #22c55e, #3b82f6);
            color: white;
            padding: 1rem;
            font-size: 1rem;
            text-align: left;
        }

        td {
            padding: 0.9rem 1rem;
            border-bottom: 1px solid #e5e7eb;
            font-size: 0.95rem;
        }

        tr:nth-child(even) td {
            background: #f9fafb;
        }

        tr:hover td {
            background: #ecfdf5;
        }

        .back-link {
            display: inline-block;
            margin-top: 2rem;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.95rem;
            color: #fff;
            background: linear-gradient(135deg, #22c55e, #3b82f6);
            padding: 0.7rem 1.5rem;
            border-radius: 0.5rem;
            transition: all 0.3s ease;
        }

        .back-link:hover {
            box-shadow: 0 0 15px rgba(59,130,246,0.4);
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
    <div class="container">
        <h3>Residents</h3>

        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Aadhaar</th>
                <th>Address</th>
            </tr>
            <%
            Connection con = null;
            Statement st = null;
            ResultSet rs = null;
            try {
                con = DBConnection.getConnection();
                st = con.createStatement();
                rs = st.executeQuery("SELECT id,name,email,aadhaar,address FROM resident ORDER BY id DESC");
                while(rs.next()){
            %>
            <tr>
              <td><%=rs.getInt("id")%></td>
              <td><%=rs.getString("name")%></td>
              <td><%=rs.getString("email")%></td>
              <td><%=rs.getString("aadhaar")%></td>
              <td><%=rs.getString("address")%></td>
            </tr>
            <%
                }
            } catch(Exception e){
                out.print("<tr><td colspan='5' style='color:red'>Error: "+e.getMessage()+"</td></tr>");
            } finally {
                if(rs!=null) try{ rs.close(); } catch(Exception ex){}
                if(st!=null) try{ st.close(); } catch(Exception ex){}
            }
            %>
        </table>

        <a href="dashboard.jsp" class="back-link">← Back to Dashboard</a>
    </div>
</body>
</html>
