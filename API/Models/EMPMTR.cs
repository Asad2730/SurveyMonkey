//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace API.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class EMPMTR
    {
        public string Emp_no { get; set; }
        public string Emp_firstname { get; set; }
        public string Emp_lastname { get; set; }
        public string Emp_middle { get; set; }
        public string Dsgn_no { get; set; }
        public string Emp_email { get; set; }
        public Nullable<System.DateTime> Joining_date { get; set; }
        public Nullable<System.DateTime> Resign_date { get; set; }
        public string Status { get; set; }
        public Nullable<bool> IsWorking { get; set; }
        public string Password { get; set; }
        public string Roles { get; set; }
    }
}