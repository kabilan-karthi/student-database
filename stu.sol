struct Course {
    uint256 id;
    string name;
    uint256 credits;
}

mapping(uint256 => Student) public students;
mapping(uint256 => Course) public courses;
uint256 public studentCount;
uint256 public courseCount;

event StudentAdded(uint256 id, string name, uint256 age, string major);
event CourseAdded(uint256 id, string name, uint256 credits);
event Enrolled(uint256 studentId, uint256 courseId);

function addStudent(uint256 _id, string memory _name, uint256 _age, string memory _major) public {
    require(students[_id].id == 0, "Student already exists");

    Student memory newStudent = Student(_id, _name, _age, _major, new uint256[](0));
    students[_id] = newStudent;
    studentCount++;

    emit StudentAdded(_id, _name, _age, _major);
}

function addCourse(uint256 _id, string memory _name, uint256 _credits) public {
    require(courses[_id].id == 0, "Course already exists");

    Course memory newCourse = Course(_id, _name, _credits);
    courses[_id] = newCourse;
    courseCount++;

    emit CourseAdded(_id, _name, _credits);
}

function enrollStudent(uint256 _studentId, uint256 _courseId) public {
    require(students[_studentId].id != 0, "Student does not exist");
    require(courses[_courseId].id != 0, "Course does not exist");

    students[_studentId].courseIds.push(_courseId);

    emit Enrolled(_studentId, _courseId);
}

function getStudent(uint256 _id) public view returns (uint256, string memory, uint256, string memory, uint256[] memory) {
    require(students[_id].id != 0, "Student does not exist");

    Student memory student = students[_id];
    return (student.id, student.name, student.age, student.major, student.courseIds);
}

function getCourse(uint256 _id) public view returns (uint256, string memory, uint256) {
    require(courses[_id].id != 0, "Course does not exist");

    Course memory course = courses[_id];
    return (course.id, course.name, course.credits);
}
