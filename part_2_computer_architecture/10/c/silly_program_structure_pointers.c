

struct Employee {
    char *Name; 
    long Salary;
    long Points;
    struct Employee *Supervisor;
}

/* Annual raise program */
/* This procedure accepts a pointer to a struct array*/
Raise(struct Employee p[]){

    int i;
    for (i=0, i< 100; i = i + 1) {
        p->Salary = 
            p->Salary
            + 100
            + p->Points;
        p->Points = 0;
        p = p +1;
        Check(p);
    }
}

/* Make sure employee is getting less than boss: */
/* This Check procedure accepts a pointer to a single Struct Element*/
Check(struct Employee *e){
    if (e == e->Supervisor) return; /* Ignore the president*/

    /* The salary of e should be lass then the salary of the supervisor
    the beautiful pointer structure syntax allows for checking this this way*/
    if (e->Salary <(e->Supervisor)->Salary) return; 

    /* When e's boos is making no more than e is,
     * give boss a raise, then check that boss's 
     * new salary causes no additional problems: 
     */

    (e->Supervisor)->Salary = 1 + e->Salary;
    Check(e->Supervisor);


}