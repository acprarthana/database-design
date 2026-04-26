create table hostel (
    hostel_id integer primary key,
    hostel_name varchar
);

create table room (
    room_id integer primary key,
    hostel_id integer,
    capacity integer,
    foreign key (hostel_id) references hostel(hostel_id)
);

create table student (
    student_id integer primary key,
    name text,
    room_id integer,
    foreign key (room_id) references room(room_id)
);

create table student_phone (
    phone_id integer primary key,
    student_id integer unique,
    phone text,
    foreign key (student_id) references student(student_id),
    
);

create table warden (
    warden_id integer primary key,
    name varchar
);

create table hostel_warden (
    hostel_id integer,
    warden_id integer,
    primary key (hostel_id, warden_id),
    foreign key (hostel_id) references hostel(hostel_id),
    foreign key (warden_id) references warden(warden_id)
);

create table maintenance_staff (
    staff_id integer primary key,
    name text
);

create table complaint (
    complaint_id integer primary key,
    student_id integer,
    room_id integer,
    description text,
    status text,
    created_at date,
    updated_at date,
    foreign key (student_id) references student(student_id),
    foreign key (room_id) references room(room_id)
);

create table complaint_assignment (
    complaint_id integer,
    staff_id integer,
    primary key (complaint_id, staff_id),
    foreign key (complaint_id) references complaint(complaint_id),
    foreign key (staff_id) references maintenance_staff(staff_id)
);




insert into hostel values (1, 'a block');
insert into hostel values (2, 'b block');

insert into room values (101, 1, 2);
insert into room values (201, 2, 3);

insert into student values (1, 'ravi', 101);
insert into student values (2, 'anu', 101);

insert into student_phone values (1, 1, '9876543210');
insert into student_phone values (3, 2, '8888888888');

insert into warden values (1, 'Kumar');

insert into hostel_warden values (1, 1);

insert into maintenance_staff values (1, 'suresh');
insert into maintenance_staff values (2, 'ramesh');

insert into complaint values 
(1, 1, 101, 'fan not working', 'pending', '2026-04-25', '2026-04-25'),
(2, 2, 101, 'light issue', 'resolved', '2026-04-25', '2026-04-25');

insert into complaint_assignment values (1, 1);
insert into complaint_assignment values (1, 2);


select s.name, h.hostel_name
from student s
join room r on s.room_id = r.room_id
join hostel h on r.hostel_id = h.hostel_id;

select c.description, m.name as staff_name
from complaint c
join complaint_assignment ca on c.complaint_id = ca.complaint_id
join maintenance_staff m on ca.staff_id = m.staff_id;


select s.name, c.description, c.status, r.room_id
from complaint c
join student s on c.student_id = s.student_id
join room r on c.room_id = r.room_id;
