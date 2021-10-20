using AmpleChat_API.Database.Models;
using Microsoft.EntityFrameworkCore;

namespace AmpleChat_API.Database
{
    public class DatabaseService : DbContext
    {
        public DbSet<User> Users { get; set; }

        public DbSet<ContactRequest> ContactRequests { get; set; }

        public DbSet<ChatMessage> ChatMessages { get; set; }

        public DatabaseService(DbContextOptions<DatabaseService> options)
        : base(options)
        {
           
        }

        protected override void OnModelCreating(ModelBuilder modelbuilder)
        {
            base.OnModelCreating(modelbuilder);

            // One to many, user & contacts
            modelbuilder.Entity<User>()
                .HasMany(i => i.Contacts)
                .WithOne()
                .OnDelete(DeleteBehavior.NoAction);


            // One to many, user & contactrequest
            modelbuilder.Entity<User>()
                .HasMany(i => i.ContactRequests)
                .WithOne(i => i.User)
                .HasForeignKey(i => i.UserId)
                .OnDelete(DeleteBehavior.NoAction);


            // One to many, user & message
            modelbuilder.Entity<User>()
                .HasMany(i => i.Messages)
                .WithOne(i => i.User)
                .HasForeignKey(i => i.UserId)
                .OnDelete(DeleteBehavior.NoAction);
        }
    }
}
