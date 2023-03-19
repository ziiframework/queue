<?php
/**
 * @link http://www.yiiframework.com/
 * @copyright Copyright (c) 2008 Yii Software LLC
 * @license http://www.yiiframework.com/license/
 */

namespace yii\queue\closure;

use yii\queue\JobInterface;

/**
 * Closure Job.
 *
 * @author Roman Zhuravlev <zhuravljov@gmail.com>
 */
class Job implements JobInterface
{
    /**
     * @var string serialized closure
     */
    public $serialized;


    /**
     * Unserializes and executes a closure.
     * @inheritdoc
     */
    public function execute($queue)
    {
        $closure = unserialize($this->serialized)->getClosure();

        // function () {}
        $unserialized = $closure();

        if ($unserialized instanceof \Closure) {
            return $unserialized();
        }

        return $unserialized->execute($queue);
    }
}
