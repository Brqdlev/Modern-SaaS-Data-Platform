        -- FOR MY SQL OLTP SYSTEMS
CREATE TABLE accounts (
  account_id INT PRIMARY KEY,
  account_name VARCHAR(100) NOT NULL,
  account_status VARCHAR(20) NOT NULL,     -- active, suspended, canceled
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
    ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE users (
  user_id INT PRIMARY KEY,
  account_id INT NOT NULL,
  email VARCHAR(255) NOT NULL,
  role VARCHAR(20) NOT NULL,                -- admin, member
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
    ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE subscriptions (
  subscription_id INT PRIMARY KEY,
  account_id INT NOT NULL,
  plan_name VARCHAR(50) NOT NULL,            -- basic, pro, enterprise
  monthly_price DECIMAL(10,2) NOT NULL,
  subscription_status VARCHAR(20) NOT NULL,  -- active, paused, canceled
  start_date DATE NOT NULL,
  end_date DATE,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
    ON UPDATE CURRENT_TIMESTAMP
);



CREATE TABLE billing_events (
  event_id INT AUTO_INCREMENT PRIMARY KEY,
  account_id INT NOT NULL,
  event_type VARCHAR(20) NOT NULL,
  event_amount DECIMAL(10,2) NOT NULL,
  event_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);



CREATE TABLE usage_events (
  event_id INT AUTO_INCREMENT PRIMARY KEY,
  account_id INT NOT NULL,
  feature_name VARCHAR(50) NOT NULL,
  usage_count INT NOT NULL,
  event_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);



        -- FOR MS SQL server OLTP SYSTEMS

CREATE TABLE incidents (
  incident_id INT PRIMARY KEY,
  account_id INT NOT NULL,
  incident_type VARCHAR(30) NOT NULL,         -- outage, performance
  severity VARCHAR(10) NOT NULL,               -- low, medium, high
  incident_status VARCHAR(20) NOT NULL,       -- open, resolved
  created_at DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
  updated_at DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);


CREATE TABLE incident_events (
  event_id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  incident_id INT NOT NULL,
  event_type VARCHAR(30) NOT NULL,
  event_time DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);




CREATE TABLE login_events (
  event_id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  user_id INT NOT NULL,
  login_time DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
  ip_address VARCHAR(45)
);

