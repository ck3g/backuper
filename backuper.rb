require 'ftools'

# setup configuration parameters
database = 'database'
username = 'username'
password = 'password'

backup_dir = './backups'
file_prefix = 'hb_'
date_format = '%Y.%m.%d'

unless (File.directory?( backup_dir ))
	File.makedirs backup_dir
end

filename = "#{backup_dir}/#{file_prefix}#{Time.new.strftime( date_format )}.sql"
included_arguments = %W[--compact --skip-triggers --no-create-info]
arguments = included_arguments.join( ' ' )
command = "mysqldump --user=#{username} --password=#{password} #{arguments} #{database} > #{filename}"
system command

if (File.exists?( filename ))
	system "tar czf #{filename}.tar.gz #{filename}"
	if (File.exists?( "#{filename}.tar.gz" ))
		File.unlink( filename )
	end
end

