#!/bin/bash
set -eux  # exit on error + debug logs

# -----------------------
# 1. Update system
# -----------------------
yum update -y || dnf update -y

# -----------------------
# 2. Install Nginx (handles AL2 + AL2023)
# -----------------------
if command -v amazon-linux-extras &> /dev/null; then
  amazon-linux-extras install nginx1 -y
else
  dnf install nginx -y
fi

# -----------------------
# 3. Start & Enable Nginx
# -----------------------
systemctl daemon-reexec
systemctl start nginx
systemctl enable nginx

# -----------------------
# 4. Create simple webpage
# -----------------------
cat <<EOF > /usr/share/nginx/html/index.html
<!DOCTYPE html>
<html>
<head>
  <title>Yash Terraform Server</title>
</head>
<body>
  <h1>🚀 Nginx is running on EC2!</h1>
  <p>Provisioned via Terraform (user_data).</p>
</body>
</html>
EOF

# -----------------------
# 5. Validate & Restart
# -----------------------
nginx -t
systemctl restart nginx