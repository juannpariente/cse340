-- ========================================
-- Organization Table
-- ========================================
CREATE TABLE organization (
    organization_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    contact_email VARCHAR(255) NOT NULL,
    logo_filename VARCHAR(255) NOT NULL
);

-- ========================================
-- Insert sample data: Organizations
-- ========================================
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