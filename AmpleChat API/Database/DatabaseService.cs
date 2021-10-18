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

        protected override void OnModelCreating(ModelBuilder builder)
        {
            base.OnModelCreating(builder);

            // One to many, user & contacts
            builder.Entity<User>()
                .HasMany(i => i.Contacts)
                .WithOne()
                .OnDelete(DeleteBehavior.NoAction);


            // One to many, user & contactrequest
            builder.Entity<User>()
                .HasMany(i => i.ContactRequests)
                .WithOne(i => i.User)
                .HasForeignKey(i => i.UserId)
                .OnDelete(DeleteBehavior.NoAction);


            // One to many, user & message
            builder.Entity<User>()
                .HasMany(i => i.Messages)
                .WithOne(i => i.User)
                .HasForeignKey(i => i.UserId)
                .OnDelete(DeleteBehavior.NoAction);
        }
    }
}
