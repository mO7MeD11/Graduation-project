import '../entities/complaint.dart';

abstract class HomeRepository {
  Future<void> submitComplaint(Complaint complaint);
}