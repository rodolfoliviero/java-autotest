class File
  def self.find_java_files(dir="src", filename="*.java")
    Dir[ File.join(dir.split(/\\/), "**", filename) ]
  end
end
