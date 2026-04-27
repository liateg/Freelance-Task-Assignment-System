CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    role VARCHAR(10) NOT NULL CHECK (role IN ('user', 'admin')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    created_by INTEGER REFERENCES users(id) ON DELETE SET NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE items (
    id SERIAL PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    category_id INTEGER REFERENCES categories(id) ON DELETE SET NULL,

    location VARCHAR(150) NOT NULL,
    date_found DATE NOT NULL,
    image_url TEXT,

    -- verification system
    verification_question TEXT NOT NULL,
    verification_answer TEXT NOT NULL,

    -- hidden info revealed after claim approval
    hidden_details TEXT,

    status VARCHAR(15) NOT NULL CHECK (status IN ('available', 'claimed', 'resolved')) DEFAULT 'available',

    posted_by INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE claims (
    id SERIAL PRIMARY KEY,

    item_id INTEGER NOT NULL REFERENCES items(id) ON DELETE CASCADE,
    claimant_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,

    answer_attempt TEXT NOT NULL,

    status VARCHAR(15) NOT NULL CHECK (
        status IN ('pending', 'approved', 'rejected', 'withdrawn')
    ) DEFAULT 'pending',

    review_note TEXT,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE reports (
    id SERIAL PRIMARY KEY,

    reporter_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,

    item_id INTEGER REFERENCES items(id) ON DELETE CASCADE,
    claim_id INTEGER REFERENCES claims(id) ON DELETE CASCADE,

    reason VARCHAR(20) NOT NULL CHECK (
        reason IN ('fake', 'spam', 'wrong_owner', 'other')
    ),

    description TEXT,

    status VARCHAR(20) NOT NULL CHECK (
        status IN ('pending', 'under_review', 'resolved', 'rejected')
    ) DEFAULT 'pending',

    admin_note TEXT,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



ALTER TABLE reports
ADD CONSTRAINT check_item_or_claim
CHECK (
    item_id IS NOT NULL OR claim_id IS NOT NULL
);


CREATE INDEX idx_items_category ON items(category_id);
CREATE INDEX idx_items_status ON items(status);
CREATE INDEX idx_claims_item ON claims(item_id);
CREATE INDEX idx_claims_status ON claims(status);
CREATE INDEX idx_reports_status ON reports(status);


CREATE OR REPLACE FUNCTION update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
   NEW.updated_at = CURRENT_TIMESTAMP;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER update_items_timestamp
BEFORE UPDATE ON items
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

CREATE TRIGGER update_claims_timestamp
BEFORE UPDATE ON claims
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

CREATE TRIGGER update_reports_timestamp
BEFORE UPDATE ON reports
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();