﻿//------------------------------------------------------------------------------
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
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class survey_monkey_databaseEntities2 : DbContext
    {
        public survey_monkey_databaseEntities2()
            : base("name=survey_monkey_databaseEntities2")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<Accgpa> Accgpas { get; set; }
        public virtual DbSet<ActiveSurvey> ActiveSurveys { get; set; }
        public virtual DbSet<AggScore> AggScores { get; set; }
        public virtual DbSet<conductsurvey> conductsurveys { get; set; }
        public virtual DbSet<course> courses { get; set; }
        public virtual DbSet<Crsdtl> Crsdtls { get; set; }
        public virtual DbSet<crsdtl_enrl> crsdtl_enrl { get; set; }
        public virtual DbSet<CRSMTR> CRSMTRs { get; set; }
        public virtual DbSet<CrsmtrShort> CrsmtrShorts { get; set; }
        public virtual DbSet<Question_Answer> Question_Answer { get; set; }
        public virtual DbSet<SEMMTR> SEMMTRs { get; set; }
        public virtual DbSet<survey> surveys { get; set; }
        public virtual DbSet<surveyaudience> surveyaudiences { get; set; }
        public virtual DbSet<surveyquestion> surveyquestions { get; set; }
        public virtual DbSet<surveyresponse> surveyresponses { get; set; }
        public virtual DbSet<teacher> teachers { get; set; }
        public virtual DbSet<ALLOCATE> ALLOCATEs { get; set; }
        public virtual DbSet<CrsdtlTemp> CrsdtlTemps { get; set; }
        public virtual DbSet<CrsEnrF> CrsEnrFs { get; set; }
        public virtual DbSet<CrsEnrp> CrsEnrps { get; set; }
        public virtual DbSet<CrsFail> CrsFails { get; set; }
        public virtual DbSet<CRSPRE> CRSPREs { get; set; }
        public virtual DbSet<EMPMTR> EMPMTRs { get; set; }
        public virtual DbSet<semReg> semRegs { get; set; }
        public virtual DbSet<STMTR> STMTRs { get; set; }
    }
}
