# @Author: Robert D. Cotey II <coteyr@coteyr.net>
# @Date:   2016-12-22 06:04:20
# @Last Modified by:   Robert D. Cotey II <coteyr@coteyr.net>
# @Last Modified time: 2017-01-05 12:35:55

Delayed::Worker.destroy_failed_jobs = false
Delayed::Worker.sleep_delay = 60
Delayed::Worker.max_attempts = 3
Delayed::Worker.max_run_time = 60.minutes
Delayed::Worker.read_ahead = 10
Delayed::Worker.default_queue_name = 'default'
Delayed::Worker.delay_jobs = !Rails.env.development?
Delayed::Worker.raise_signal_exceptions = :term
Delayed::Worker.logger = Logger.new(File.join(Rails.root, 'log', 'delayed_job.log'))
