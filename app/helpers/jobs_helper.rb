module JobsHelper
  # Returns a pretty job status based on locks status and fail count
  def job_status(job)
    if job.failed?
      return "Failed"
    elsif !job.locked_by.blank?
      return "Running"
    elsif job.attempts == 0
      return "Pending"
    else
      return "Unknown"
    end
  end
end
