require 'spec_helper'

describe Doctor do
  describe 'initialize' do
    it 'initializes a new Doctor object' do
      new_doctor = Doctor.new({:name => "Dr. John Smith", :specialty_id => 2})
      new_doctor.should be_an_instance_of Doctor
    end
    it 'knows its name and specialty' do
      new_doctor = Doctor.new({:name => "Sally Smith", :specialty_id => 1})
      new_doctor.name.should eq "Sally Smith"
      new_doctor.specialty_id.should eq 1
    end
  end

  describe '.all' do
    it 'starts off empty' do
      Doctor.all.should eq []
    end
  end

  describe '#save' do
    it 'allows a doctor object to save itself to the database' do
      new_doctor = Doctor.new({:name => "Sally Smith", :specialty_id => 1})
      new_doctor.save
      Doctor.all.should eq [new_doctor]
    end
  end

  describe '#==' do
    it 'considers doctor objects with the same name and specialty_id to be equal' do
      new_doctor1 = Doctor.new({:name => "Sally Smith", :specialty_id => 1})
      new_doctor2 = Doctor.new({:name => "Sally Smith", :specialty_id => 1})
      new_doctor1.should eq new_doctor2
    end
  end

  describe '#delete' do
    it 'deletes a doctor from the database' do
      new_doctor = Doctor.new({:name => "Doctor Name", :specialty_id => 9})
      new_doctor.save
      new_doctor.delete
      Doctor.all.should eq []
    end
  end

  describe '#update' do
    it 'updates the name and specialty_id in the database' do
      new_doctor = Doctor.new({:name => "Doctor Name", :specialty_id => 9})
      new_doctor.save
      new_doctor.update("Doctor New Name", 9)
      results = DB.exec("SELECT * FROM doctors WHERE id = #{new_doctor.id};")
      results.first['name'].should eq 'Doctor New Name'
    end
  end

end
