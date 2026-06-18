CREATE TABLE organization (
    organization_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    contact_email VARCHAR(255) NOT NULL,
    logo_filename VARCHAR(255) NOT NULL
);

INSERT INTO organization (name, description, contact_email, logo_filename)
VALUES
('BrightFuture Builders', 'A nonprofit focused on improving community infrastructure through sustainable construction projects.', 'info@brightfuturebuilders.org', 'brightfuture-logo.png'),
('GreenHarvest Growers', 'An urban farming collective promoting food sustainability and education in local neighborhoods.', 'contact@greenharvest.org', 'greenharvest-logo.png'),
('UnityServe Volunteers', 'A volunteer coordination group supporting local charities and service initiatives.', 'hello@unityserve.org', 'unityserve-logo.png');

CREATE TABLE service_projects (
  project_id SERIAL PRIMARY KEY,
  organization_id INT NOT NULL,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  location VARCHAR(255),
  date DATE,

  CONSTRAINT fk_organization
    FOREIGN KEY (organization_id)
    REFERENCES organization(organization_id)
    ON DELETE CASCADE
);

INSERT INTO service_projects (
  organization_id,
  title,
  description,
  location,
  date
)
VALUES

-- Organization 1
(1, 'Community Food Drive',
 'Collect and distribute food to families in need.',
 'New York, NY',
 '2026-06-10'),

(1, 'Park Cleanup Initiative',
 'Volunteers clean parks and public spaces.',
 'Chicago, IL',
 '2026-07-05'),

(1, 'School Supply Donation',
 'Provide school materials to underprivileged students.',
 'Dallas, TX',
 '2026-08-15'),

(1, 'Senior Assistance Program',
 'Support elderly residents with daily needs.',
 'Miami, FL',
 '2026-09-20'),

(1, 'Neighborhood Tree Planting',
 'Plant trees to improve green spaces.',
 'Seattle, WA',
 '2026-10-12'),

-- Organization 2
(2, 'Youth Coding Workshop',
 'Teach programming basics to teenagers.',
 'San Francisco, CA',
 '2026-06-18'),

(2, 'Beach Cleanup Project',
 'Remove waste and protect coastal areas.',
 'Los Angeles, CA',
 '2026-07-22'),

(2, 'Health Awareness Campaign',
 'Promote healthy habits and prevention.',
 'Boston, MA',
 '2026-08-30'),

(2, 'Community Sports Day',
 'Organize sports activities for local youth.',
 'Denver, CO',
 '2026-09-14'),

(2, 'Book Donation Program',
 'Collect books for schools and libraries.',
 'Austin, TX',
 '2026-10-28'),

-- Organization 3
(3, 'Homeless Shelter Support',
 'Provide meals and essential items.',
 'Philadelphia, PA',
 '2026-06-25'),

(3, 'Environmental Education Event',
 'Teach sustainability and recycling practices.',
 'Portland, OR',
 '2026-07-16'),

(3, 'Community Garden Project',
 'Build gardens for local neighborhoods.',
 'Atlanta, GA',
 '2026-08-11'),

(3, 'Technology Access Program',
 'Donate computers to students.',
 'Phoenix, AZ',
 '2026-09-07'),

(3, 'Animal Rescue Volunteer Day',
 'Support local animal shelters.',
 'Nashville, TN',
 '2026-10-19');

 CREATE TABLE categories (
  category_id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE project_categories (
  project_id INT NOT NULL,
  category_id INT NOT NULL,

  PRIMARY KEY (project_id, category_id),

  CONSTRAINT fk_project
    FOREIGN KEY (project_id)
    REFERENCES service_projects(project_id)
    ON DELETE CASCADE,

  CONSTRAINT fk_category
    FOREIGN KEY (category_id)
    REFERENCES categories(category_id)
    ON DELETE CASCADE
);

INSERT INTO categories (name)
VALUES
('Education'),
('Environment'),
('Community Support'),
('Technology'),
('Health');

INSERT INTO project_categories (project_id, category_id)
VALUES

-- Organization 1
(1, 3), -- Community Food Drive → Community Support
(2, 2), -- Park Cleanup Initiative → Environment
(3, 1), -- School Supply Donation → Education
(4, 3), -- Senior Assistance Program → Community Support
(5, 2), -- Neighborhood Tree Planting → Environment

-- Organization 2
(6, 1), -- Youth Coding Workshop → Education
(6, 4), -- Youth Coding Workshop → Technology
(7, 2), -- Beach Cleanup Project → Environment
(8, 5), -- Health Awareness Campaign → Health
(9, 3), -- Community Sports Day → Community Support
(10, 1), -- Book Donation Program → Education

-- Organization 3
(11, 3), -- Homeless Shelter Support → Community Support
(12, 2), -- Environmental Education Event → Environment
(12, 1), -- Environmental Education Event → Education
(13, 2), -- Community Garden Project → Environment
(13, 3), -- Community Garden Project → Community Support
(14, 4), -- Technology Access Program → Technology
(14, 1), -- Technology Access Program → Education
(15, 3); -- Animal Rescue Volunteer Day → Community Support

CREATE TABLE roles (
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR(50) UNIQUE NOT NULL,
    role_description TEXT
);

INSERT INTO roles (role_name, role_description) VALUES 
    ('user', 'Standard user with basic access'),
    ('admin', 'Administrator with full system access');

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role_id INTEGER REFERENCES roles(role_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE project_volunteers (
  project_id INT NOT NULL,
  user_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  PRIMARY KEY (project_id, user_id),

  CONSTRAINT fk_project
    FOREIGN KEY (project_id)
    REFERENCES service_projects(project_id)
    ON DELETE CASCADE,

  CONSTRAINT fk_user
    FOREIGN KEY (user_id)
    REFERENCES users(user_id)
    ON DELETE CASCADE
);